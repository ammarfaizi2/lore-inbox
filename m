Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbTGHWM2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 18:12:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267786AbTGHWM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 18:12:27 -0400
Received: from fmr06.intel.com ([134.134.136.7]:41937 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S267773AbTGHWLv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 18:11:51 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: Forking shell bombs
Date: Tue, 8 Jul 2003 15:26:25 -0700
Message-ID: <A20D5638D741DD4DBAAB80A95012C0AE172EC9@orsmsx409.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Forking shell bombs
Thread-Index: AcNFnuuphgghF8UiR/KRDO2pun+/FgAAPZzg
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "Max Valdez" <maxvalde@fis.unam.mx>, <system_lists@nullzone.org>,
       "kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Jul 2003 22:26:25.0911 (UTC) FILETIME=[F7FC0070:01C3459F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Max Valdez [mailto:maxvalde@fis.unam.mx]
>
> I set the ulimit -u 1791
> and the box keeps running(2.4.20-gentoo-r5) , but we still need the
> problem corrected, any other user can run ther DOS and crash the box, is
> there any way to set ulimits for all users fixed ??, not by sourcein a
> bashrc or something like that ?? because the user can delete the line on
> .bashrc and thats it

/etc/profile. 

This is an admin/distro problem.

Iñaky Pérez-González -- Not speaking for Intel -- all opinions are my own (and my fault)
