Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964948AbVHaUvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964948AbVHaUvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 16:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964949AbVHaUvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 16:51:11 -0400
Received: from orb.pobox.com ([207.8.226.5]:20707 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S964948AbVHaUvK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 16:51:10 -0400
Message-ID: <43161833.10307@rtr.ca>
Date: Wed, 31 Aug 2005 16:50:59 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Mark Lord <mlord@pobox.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: APs from the Kernel Summit run Linux
References: <20050830093715.GA9781@midnight.suse.cz> <4315E0F0.6060209@pobox.com> <20050831205319.A6385@flint.arm.linux.org.uk> <20050831203211.GA13752@midnight.suse.cz>
In-Reply-To: <20050831203211.GA13752@midnight.suse.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >Each of the first three large parts starts with this sequence of bytes

Actually, the byte structure of the first 0x100 bytes
of each section seems to be very similar.

Some kind of header.
