Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751605AbWHKGTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbWHKGTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751606AbWHKGTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:19:48 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:53687 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751605AbWHKGTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:19:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=p9VoZaMdxxgXZQpfFzLE21OFpqoA8L2YHC0+XUcpzPdMY+qOLJMnsBsoC6sfdYTt2UUHZR4LWBj/MOFKgsnISVmqJilLR+SvMsSRECtlm6XvH5n7dNFKk/C73nA5VlMWzHg0r8k6gBwDr4/Fp0bHaFhkL/Q/WOUVtFJGRffvW6U=
Message-ID: <6de39a910608102319h76cfe171w1dab7aa700709dcf@mail.gmail.com>
Date: Thu, 10 Aug 2006 23:19:42 -0700
From: "Om N." <xhandle@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: RFC : remote driver debugging efforts
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to debug a driver ported from 2.4 to 2.6 for a friend. But
the device is custom made and not available anywhere else, only with
my friend.
he suggested me that I do remote debugging using telnet/ssh.

For all driver development efforts I have carried out so far, I had
free and close proximity access to the device, the target machine and
a serial port. Now
in this case, without a serial port console, and without remote power off/on
facilities, I would like to ask the list about the options I have.

(I do not have a remote power on/off switch. The driver panics so
often that somebody has to babysit the machine to switch it off and
on. We are in different time zones and things are not moving forward at all)

Regards,
Om.
