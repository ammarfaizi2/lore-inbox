Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTKFRJY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 12:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263757AbTKFRJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 12:09:24 -0500
Received: from pop.gmx.net ([213.165.64.20]:23711 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263765AbTKFRJC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 12:09:02 -0500
Date: Thu, 6 Nov 2003 18:09:01 +0100 (MET)
From: "Daniel Blueman" <daniel.blueman@gmx.net>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [DMESG] cpumask_t in action
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0008973862@gmx.net
X-Authenticated-IP: [194.202.174.105]
Message-ID: <13530.1068138541@www42.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hash tables naturally give less and less incremental benefit as they are
made larger, so it would be natural to size them by [coeff * log(mem_size)].

I thought this was already done, no?

-- 
Daniel J Blueman

NEU FÜR ALLE - GMX MediaCenter - für Fotos, Musik, Dateien...
Fotoalbum, File Sharing, MMS, Multimedia-Gruß, GMX FotoService

Jetzt kostenlos anmelden unter http://www.gmx.net

+++ GMX - die erste Adresse für Mail, Message, More! +++

