Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbTLXVDf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 16:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTLXVDf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 16:03:35 -0500
Received: from fep03-mail.bloor.is.net.cable.rogers.com ([66.185.86.73]:7723
	"EHLO fep03-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263868AbTLXVDe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 16:03:34 -0500
Date: Wed, 24 Dec 2003 16:03:32 -0500
From: Sean Estabrooks <seanlkml@rogers.com>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NEW FEATURE]Partitions on loop device for 2.6
Message-Id: <20031224160332.76db82a0.seanlkml@rogers.com>
In-Reply-To: <200312242004.14750.blaisorblade_spam@yahoo.it>
References: <200312241341.23523.blaisorblade_spam@yahoo.it>
	<200312242004.14750.blaisorblade_spam@yahoo.it>
Organization: 
X-Mailer: Sylpheed version 0.9.4-gtk2-20030802 (GTK+ 2.2.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Wed__24_Dec_2003_16:03:32_-0500_082e4530"
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep03-mail.bloor.is.net.cable.rogers.com from [24.103.218.41] using ID <seanlkml@rogers.com> at Wed, 24 Dec 2003 16:03:02 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Wed__24_Dec_2003_16:03:32_-0500_082e4530
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Dec 2003 20:04:14 +0100
BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

> this could  actually be scripted, and if you post a script to do this
> I could even use it.

The script attached works here to mount a given partition in a disk image
but it comes without a warranty ;o) 

Cheers,
Sean

--Multipart_Wed__24_Dec_2003_16:03:32_-0500_082e4530
Content-Type: application/octet-stream;
 name="disk.mount"
Content-Disposition: attachment;
 filename="disk.mount"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCiMgIFVzYWdlOiAgZGlzay5tb3VudCA8aW1hZ2VfZmlsZW5hbWU+IFttb3VudF9w
b2ludCBbcGFydGl0aW9uXyNdIApGSUxFPSQxIDsgTU5UPSQyIDsgUEFSVD0kMwpVTklUUz1gZmRp
c2sgLWwgIiRGSUxFIiAyPiYxIHwgc2VkIC1uZSAncyNeWzAtOV0qIGhlYWRzLCBcKFswLTldKlwp
IHNlY3RvcnMuKiQjXDEjcCdgCkNZTD1gZmRpc2sgLWwgIiRGSUxFIiAyPiYxIHwgc2VkIC1uZSAi
cyNeJEZJTEUke1BBUlQ6PTF9WyAqXSpcKFswLTldKlwpLiojXDEjcCJgClNUQVJUPSQoKFVOSVRT
KkNZTCo1MTIpKQptb3VudCAiJEZJTEUiICIke01OVDo9L21udC9pbWFnZX0iIC1vbG9vcCxvZmZz
ZXQ9JFNUQVJUCg==

--Multipart_Wed__24_Dec_2003_16:03:32_-0500_082e4530--
