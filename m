Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129528AbRBTMyN>; Tue, 20 Feb 2001 07:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130262AbRBTMyD>; Tue, 20 Feb 2001 07:54:03 -0500
Received: from mx1.otto.de ([194.25.18.215]:29194 "EHLO ntovmsw.otto.de")
	by vger.kernel.org with ESMTP id <S129528AbRBTMxw>;
	Tue, 20 Feb 2001 07:53:52 -0500
Message-Id: <4B6025B1ABF9D211B5860008C75D57CC0271B905@NTOVMAIL04>
From: "Butter, Frank" <Frank.Butter@otto.de>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: kernel params
Date: Tue, 20 Feb 2001 13:54:04 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there any possibility to set the values for IPC-ressources
(SHM/SEM) other than by changing the headerfiles?

A software we want to install wants us to have set the following
values:

SHM MAX 33554432
SHM MIN 1
    MNI 128
    SEG 128
SEM MNI 128
SEM MNS 4096
SEM MNU 4096
SEM ONE 32
    MSL 32
    MAP 4096

I know from HPUX that there is something like /etc/system for this kind of
params...

Frank

