Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263071AbRFAOwE>; Fri, 1 Jun 2001 10:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263554AbRFAOvy>; Fri, 1 Jun 2001 10:51:54 -0400
Received: from [193.15.48.107] ([193.15.48.107]:26420 "EHLO dell1.connective")
	by vger.kernel.org with ESMTP id <S263071AbRFAOvk>;
	Fri, 1 Jun 2001 10:51:40 -0400
Message-ID: <FC79D1F4C922D511983400104BC30388018E4F@DELL1>
From: Ola Theander <ola.theander@connective.se>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: HowTo: Kernel verbose logging.
Date: Fri, 1 Jun 2001 16:51:27 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear subscribers.

I'm currently experimenting with a third party application, VMWare's
GSX-server. This application allows you to run multiple virtual servers on a
single physical computer, providing there are enough resources, such as
memory, available.

The problem is that this application under certain circumstances completely
freezes the server, and I mean completely stone dead. The only thing to do
is to turn off the power.

I'm currently discussing the problem with the VMWare support staff but we're
kind of stuck, so I would like to collect more data about the problem.

Therefore I would like to know if it's possible to compile the used kernel
(2.2.18) in some kind of verbose logging mode? Ultimately every kernel call
should be logged, with parameters and everything. I realize that this
probably isn't feasible but perhaps there is something that takes me
halfway?

Kind regards, Ola Theander
