Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261507AbSJUQck>; Mon, 21 Oct 2002 12:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261514AbSJUQck>; Mon, 21 Oct 2002 12:32:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:56214 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261507AbSJUQcj>;
	Mon, 21 Oct 2002 12:32:39 -0400
Importance: Normal
Sensitivity: 
Subject: Stress testing cifs filesystem
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF9459582D.95D99040-ON87256C59.005AD875@boulder.ibm.com>
From: "Steven French" <sfrench@us.ibm.com>
Date: Mon, 21 Oct 2002 11:38:23 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/21/2002 10:38:40 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After struggling with setting up LSB to test
remote mounts for a while, I checked
with the LSB team on Andi's suggestion below of
using the POSIX file API section of LSB on a
network mount.   They indicated that it won't
work without modifications to the LSB source,
(I had been trying to do it via just changing
the config files) something I will eventually
have to look into.

>Run the LSB test suite on it. It includes most of
>the old POSIX/Single Unix test suites, which test
>quite a lot of things and tends to find obscure
>bugs in kernels and file systemRun the LSB test suite on it. It includes
most of the old POSIX/Single Unix
Steve French
Senior Software Engineer
Linux Technology Center - IBM Austin
phone: 512-838-2294
email: sfrench@us.ibm.com


