Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318805AbSG0TH6>; Sat, 27 Jul 2002 15:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318806AbSG0TH6>; Sat, 27 Jul 2002 15:07:58 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:22286 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S318805AbSG0TH5>; Sat, 27 Jul 2002 15:07:57 -0400
Message-Id: <200207271907.g6RJ7ST27551@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org
Subject: Re: keep code simple
Date: Sat, 27 Jul 2002 22:05:34 -0200
X-Mailer: KMail [version 1.3.2]
References: <200207270323.g6R3Nkb39182@saturn.cs.uml.edu>
In-Reply-To: <200207270323.g6R3Nkb39182@saturn.cs.uml.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 July 2002 01:23, Albert D. Cahalan wrote:
> Remember that "optimized" code often runs slower than
> simple code.

A bit offtopic, but: I heard M$ and Intel compilers beat GCC
by 20-40% in terms of code size. Why GCC is so much behind?
--
vda
