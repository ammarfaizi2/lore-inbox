Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266708AbSKLSVW>; Tue, 12 Nov 2002 13:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266709AbSKLSVV>; Tue, 12 Nov 2002 13:21:21 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:22659 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S266708AbSKLSVV>; Tue, 12 Nov 2002 13:21:21 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: tcp_v4_get_port?
Date: Tue, 12 Nov 2002 19:31:27 +0100
Message-ID: <007501c28a79$b6f39d90$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am I right that in net/ipv4/tcp_ipv4.c in function "tcp_v4_get_port" the
portnumber for a new connection is generated? Because fiddling with that
code seems to have no effect on the portnumbers generated for new
connections.


Folkert
