Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUB0Sfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbUB0SeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:34:17 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:35768 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S262932AbUB0Sc7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:32:59 -0500
Message-ID: <403F8D47.4010606@matchmail.com>
Date: Fri, 27 Feb 2004 10:32:39 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helgehaf@aitel.hist.no>
CC: "Grover, Andrew" <andrew.grover@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: Why no interrupt priorities?
References: <F760B14C9561B941B89469F59BA3A84702C932F2@orsmsx401.jf.intel.com> <403F18C4.3080309@aitel.hist.no>
In-Reply-To: <403F18C4.3080309@aitel.hist.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> Or resort to
> reprogramming the APIC in extreme cases.

Would this typically require kernel code, or is there an interface 
exposed to userspace?
