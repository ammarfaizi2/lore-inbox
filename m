Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264542AbUAVPGP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:06:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264546AbUAVPGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:06:15 -0500
Received: from p-mail2.rd.francetelecom.com ([195.101.245.16]:60935 "EHLO
	p-mail2.rd.francetelecom.com") by vger.kernel.org with ESMTP
	id S264542AbUAVPGO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:06:14 -0500
From: Franck Collineau <franck1.collineau@francetelecom.com>
Reply-To: franck1.collineau@francetelecom.com
Organization: France Telecom R&D
To: linux-kernel@vger.kernel.org
Subject: catch sda1 or /dev/scsi/host1/bus0/target0/lun0
Date: Thu, 22 Jan 2004 16:04:03 +0100
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401221604.03422.franck1.collineau@francetelecom.com>
X-OriginalArrivalTime: 22 Jan 2004 15:06:12.0142 (UTC) FILETIME=[45F134E0:01C3E0F9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

When I connect a usb device, dmseg tells me which special file the device is
attached on.
This is sda1 or something like : /dev/scsi/host1/bus0/target0/lun0

I would like to catch this information in a script.
Can anybody tell me how can i do ?
 I think this is a kernel information; how can I get it ?

Thanks for your help.

FRanck

