Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbVJFIIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbVJFIIW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 04:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750728AbVJFIIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 04:08:22 -0400
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:47370 "EHLO
	smtp-vbr15.xs4all.nl") by vger.kernel.org with ESMTP
	id S1750726AbVJFIIV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 04:08:21 -0400
Message-ID: <4344DB73.9020604@bananateam.nl>
Date: Thu, 06 Oct 2005 10:08:19 +0200
From: Freaky <freaky@bananateam.nl>
User-Agent: Thunderbird 1.4 (X11/20050908)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: MTP - Media Transfer Protocol support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey there,

I don't know if this is the right place, but I would like to inquire on 
the status of MTP support in the kernel.

MTP is a new protocol by Microsoft if I'm not mistaken. It stands for 
Media Transfer Protocol. It's going to replace the mass storage support 
on a lot of new MP3 players and from what I've seen, also on other 
mobile devices like phones and camera's.

MTP, from what I've seen so far, has 2 folders at the moment (atleast on 
my MP3 device / iRiver T10). Music and Data. Music can only be written 
by software like Media Player 10, because it has to do with DRM. Data 
however can be written as a filesystem. The latter is what I would like 
support for (I don't care about DRM).

Microsoft appearantly publishes the specifications, unfortunately for 
most of us it's Microsoft word format, in an executable. Would convert 
this for you, but I don't know how legal that is.

http://www.microsoft.com/downloads/details.aspx?FamilyID=fed98ca6-ca7f-4e60-b88c-c5fce88f3eea&displaylang=en

Sorry if this is the wrong place to ask. But I figured it needs kernel 
support first, because the USB device isn't recognized at all. MTP has a 
general USB interface like mass storage from what I understand, so we'll 
need drivers for that first I think.

For those interested, PLX appearantly has written something to support 
MTP on (some?) of their chips for phones. Haven't been able to find the 
software so far.
http://www.plxtech.com/products/exp_apps/files/ExApps18_MobilePhone.pdf

As always, all you guys do is really appreciated. Keep up the good work.

TIA

Ferry
