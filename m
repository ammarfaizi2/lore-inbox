Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264749AbTARNvj>; Sat, 18 Jan 2003 08:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTARNvj>; Sat, 18 Jan 2003 08:51:39 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:54179 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S264749AbTARNvi>; Sat, 18 Jan 2003 08:51:38 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: "'Tomas Szepe'" <szepe@pinerecords.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: reading from devices in RAW mode
Date: Sat, 18 Jan 2003 15:00:25 +0100
Message-ID: <003001c2bef9$fa08cc90$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
In-Reply-To: <20030118132315.GF19381@louise.pinerecords.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Yeah, I like it when people have a full mouth of how gotos are for lazy
> folks (not even bothering to grasp the context of the discussion) and
> how they could teach masterclass C courses, then ask a total newbie
> question.

Is it such a newby question? Your suggestion of using dd is totally NOT
what I meant: I want to read from devices with the devices ignoring their
CRC-checks and such. Like what the CDROMREADRAW ioctl does for CD-ROMs.
