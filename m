Return-Path: <linux-kernel-owner+w=401wt.eu-S964923AbXASVQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964923AbXASVQF (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 16:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbXASVQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 16:16:05 -0500
Received: from mail.tmr.com ([64.65.253.246]:48758 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964923AbXASVQE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 16:16:04 -0500
Message-ID: <45B135B8.9000703@tmr.com>
Date: Fri, 19 Jan 2007 16:18:48 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Alessandro Di Marco <dmr@gmx.it>,
       Linux Kernel mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] System Inactivity Monitor v1.0
References: <877ivkrv5s.fsf@gmx.it>
In-Reply-To: <877ivkrv5s.fsf@gmx.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Di Marco wrote:
> Hi all,
> 
> this is a new 2.6.20 module implementing a user inactivity trigger. Basically
> it acts as an event sniffer, issuing an ACPI event when no user activity is
> detected for more than a certain amount of time. This event can be successively
> grabbed and managed by an user-level daemon such as acpid, blanking the screen,
> dimming the lcd-panel light à la mac, etc...

Any idea how much power this saves? And for the vast rest of us who do 
run X, this seems to parallel the work of a well-tuned screensaver.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979

