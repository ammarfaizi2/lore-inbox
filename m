Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318013AbSHZJjL>; Mon, 26 Aug 2002 05:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318017AbSHZJjL>; Mon, 26 Aug 2002 05:39:11 -0400
Received: from correo.e-technik.uni-ulm.de ([134.60.21.81]:53010 "EHLO
	correo.e-technik.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S318013AbSHZJjK>; Mon, 26 Aug 2002 05:39:10 -0400
Message-Id: <200208260943.LAA25845@correo.e-technik.uni-ulm.de>
Content-Type: text/plain; charset=US-ASCII
From: Kai-Boris Schad <kschad@ebs.e-technik.uni-ulm.de>
Reply-To: kschad@ebs.e-technik.uni-ulm.de
Organization: =?iso8859-15?q?Universit=E4t?= Ulm
To: linux-console@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Q: Howto access the keyboard in a linux system without a graphics card ?
Date: Mon, 26 Aug 2002 11:43:14 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I'm trying to set up a small embedded system for gps receiving with a linux 
system.  I want to have the system working without a graphics card - wich 
works well. The Problem I have at the moment is to access the keyboard 
without a graphics card, because the console driver does not start then ( 
Also a redirect doesn't work then :-( ) 
Is there a way to access the keyboard in this case by a user program ?
The system recognises the keyboard ( I think Kernel and init) and reacts if 
ctrl-alt-del is pressed.

Thanks for your help !

Kai

-- 
Kai-Boris Schad 
University of Ulm, Germany
Dept. of Electron Devices and Circuits
Integrated Circuits in Communications
Albert Einstein Allee 45
89069 ULM

http://www.uni-ulm.de/icic
email:kschad@ebs.e-technik.uni-ulm.de
phone +49/731/50-31581  fax +49/731/50-31599
