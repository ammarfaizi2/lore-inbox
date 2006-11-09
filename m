Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424041AbWKIEKm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424041AbWKIEKm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 23:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424042AbWKIEKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 23:10:42 -0500
Received: from outbound-cpk.frontbridge.com ([207.46.163.16]:29558 "EHLO
	outbound2-cpk-R.bigfish.com") by vger.kernel.org with ESMTP
	id S1424041AbWKIEKl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 23:10:41 -0500
X-BigFish: VP
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: Kexec with latest kernel fail
Date: Wed, 8 Nov 2006 20:07:22 -0800
Message-ID: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Kexec with latest kernel fail
Thread-Index: AccA7F1cnvnUaN0OQcmu4OqUcqZuJgB7QWKwACcu8zAAD4ZsgA==
From: "Lu, Yinghai" <yinghai.lu@amd.com>
To: ebiederm@xmission.com
cc: "Fastboot mailing list" <fastboot@lists.osdl.org>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 09 Nov 2006 04:07:23.0963 (UTC)
 FILETIME=[8F7C40B0:01C703B4]
X-WSS-ID: 694C76F11AO1193860-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric,

I got "Invalid memory segment 0x100000 - ..."
using kexec latest kernel...

Do I need patch for kexec tools with latest kexec in kernel?

YH


