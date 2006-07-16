Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWGPUY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWGPUY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 16:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWGPUY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 16:24:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:64828 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751140AbWGPUY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 16:24:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Tfr1wgiNkUoffZccX0SS5DvTGBk4UX4PxUF3xgT14W6qRefHc7qZxvb+tpDoJzuegviG0QOLpQoCBZvKrqusOxeaUNyhS+XqbUSabkOPSJXKYPZig1bkzFn0KIW83R1E+i3JGAvwJPZyvp/xHyJcRI17jhroSEv3DdRXOrBrWgQ=
Message-ID: <bda6d13a0607161324n37d10a8atbdabdb78c87d867b@mail.gmail.com>
Date: Sun, 16 Jul 2006 13:24:57 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Rescan IDE interface when no IDE devices are present
In-Reply-To: <427c54c0607161303r416c0dddt916a2b635c7431c5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <427c54c0607161212m714f4faew60b8615e06ac885a@mail.gmail.com>
	 <1153077903.5905.35.camel@localhost.localdomain>
	 <427c54c0607161303r416c0dddt916a2b635c7431c5@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if its like my laptop: hdc is hard disk, hda is cdrom, and in
this case removable so it is necessary to scan for ide0 when inserting
cdrom.
