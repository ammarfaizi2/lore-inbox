Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbTAPToV>; Thu, 16 Jan 2003 14:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267238AbTAPToV>; Thu, 16 Jan 2003 14:44:21 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:62665 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S267233AbTAPToT>; Thu, 16 Jan 2003 14:44:19 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: restricting nfs
Date: Thu, 16 Jan 2003 20:53:14 +0100
Message-ID: <003501c2bd98$e880d0b0$3640a8c0@boemboem>
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

I have a request :-)
It would be nice if it would be possible to restrict the interfaces
on which the kernel-part of nfsd is listening. Maybe not just the
interface, but like that you can say; only accept connections from
192.168.64.0/24 or so.


Folkert
