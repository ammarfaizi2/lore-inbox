Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261416AbSLADAy>; Sat, 30 Nov 2002 22:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261418AbSLADAy>; Sat, 30 Nov 2002 22:00:54 -0500
Received: from pony-express.cs.rit.edu ([129.21.30.24]:6620 "HELO
	pony-express.cs.rit.edu") by vger.kernel.org with SMTP
	id <S261416AbSLADAx>; Sat, 30 Nov 2002 22:00:53 -0500
Subject: APM issues
From: "Tristan O'Tierney" <teo2604@cs.rit.edu>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 30 Nov 2002 22:09:28 -0500
Message-Id: <1038712168.5386.2.camel@omnivector.rh.rit.edu>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
The command apm -s works flawless for me in kernel 2.4.19, however in
kernel 2.4.20 my laptop fails to awaken after that command.  Even worse
in kernel 2.5.x apm completely fails to load.  Why is it getting
progressively worse? 

- Tristan O'Tierney

