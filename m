Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263418AbRFGWBC>; Thu, 7 Jun 2001 18:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263417AbRFGWAw>; Thu, 7 Jun 2001 18:00:52 -0400
Received: from inet.connecttech.com ([206.130.75.2]:19651 "EHLO
	inet.connecttech.com") by vger.kernel.org with ESMTP
	id <S263338AbRFGWAj>; Thu, 7 Jun 2001 18:00:39 -0400
Message-ID: <0dc301c0ef9d$98d0d260$294b82ce@connecttech.com>
From: "Stuart MacDonald" <stuartm@connecttech.com>
To: "Marcelo Tosatti" <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0106071631150.1156-100000@freak.distro.conectiva>
Subject: Re: VM suggestion...
Date: Thu, 7 Jun 2001 18:02:51 -0400
Organization: Connect Tech Inc.
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Marcelo Tosatti" <marcelo@conectiva.com.br>
> The problem is that we _cannot_ base ourselves simply on practical results
> from a _limited_ amount of workloads. Also remember the tests we (at least
> I do) are benchmarks which try to use all resources all the time upon
> completion.

Isn't this the point of the X.odd.Y kernels? Spit the stats out into the
syslog, along with a message of "If you see these, please mail them
along to marcelo@conectiva.com.br and a description of your workload
if it's not too much trouble."

..Stu


