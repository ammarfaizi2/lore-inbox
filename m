Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161471AbWALXdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161471AbWALXdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 18:33:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161473AbWALXdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 18:33:42 -0500
Received: from mailin.studentenwerk.mhn.de ([141.84.225.229]:38553 "EHLO
	email.studentenwerk.mhn.de") by vger.kernel.org with ESMTP
	id S1161471AbWALXdl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 18:33:41 -0500
From: Wolfgang Walter <wolfgang.walter@studentenwerk.mhn.de>
Organization: Studentenwerk =?iso-8859-1?q?M=FCnchen?=
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: patch: problem with sco
Date: Fri, 13 Jan 2006 00:33:39 +0100
User-Agent: KMail/1.7.2
Cc: bluez-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       maxk@qualcomm.com
References: <200601120138.31791.wolfgang.walter@studentenwerk.mhn.de> <1137057244.3955.3.camel@localhost.localdomain> <200601130031.22063.wolfgang.walter@studentenwerk.mhn.de>
In-Reply-To: <200601130031.22063.wolfgang.walter@studentenwerk.mhn.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200601130033.39804.wolfgang.walter@studentenwerk.mhn.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 13. Januar 2006 00:31 schrieb Wolfgang Walter:
> Hi Marcel,
>
>
> >/usr/sbin/hciconfig -a
>
> hci0:   Type: USB
>         BD Address: 00:00:3A:6A:18:D1 ACL MTU: 1017:8 SCO MTU: 64:8

SCO MTU: 64:8 because is of our patch. Without patch it is 64:0

-- 
Wolfgang Walter
Studentenwerk München
Anstalt des öffentlichen Rechts
Leiter EDV
Leopoldstraße 15
80802 München
Tel: +49 89 38196 276
Fax: +49 89 38196 144
wolfgang.walter@studentenwerk.mhn.de
http://www.studentenwerk.mhn.de/
