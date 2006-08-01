Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWHAOk4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWHAOk4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbWHAOk4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:40:56 -0400
Received: from webmailv3.ispgateway.de ([80.67.16.113]:55264 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751311AbWHAOkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:40:55 -0400
Message-ID: <1154443252.44cf67f4dd562@domainfactory-webmail.de>
Date: Tue, 01 Aug 2006 16:40:52 +0200
From: Clemens Ladisch <clemens@ladisch.de>
To: Edgar Toernig <froese@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] /dev/itimer
References: <20060728235951.7de534eb.froese@gmx.de>
In-Reply-To: <20060728235951.7de534eb.froese@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 141.48.9.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edgar Toernig wrote:
> this is a simple driver which provides interval timers via
> file descriptors.

Interval timers are already available with ALSA (although ALSA's timer
API is neither as simple nor as script-friendly as this one).


Regards,
Clemens

