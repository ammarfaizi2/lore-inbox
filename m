Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUFLMk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUFLMk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 08:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUFLMk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 08:40:28 -0400
Received: from nepa.nlc.no ([195.159.31.6]:62395 "HELO nepa.nlc.no")
	by vger.kernel.org with SMTP id S264734AbUFLMk1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 08:40:27 -0400
Message-ID: <1191.83.109.11.80.1087044017.squirrel@nepa.nlc.no>
Date: Sat, 12 Jun 2004 14:40:17 +0200 (CEST)
Subject: Re: new kernel bug
From: stian@nixia.no
To: linux-kernel@vger.kernel.org
Cc: "Manuel Arostegui Ramirez" <manuel@todo-linux.com>
User-Agent: SquirrelMail/1.4.0-1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can keep an eye on the
"timer + fpu stuff locks my console race"
thread I orignaly created when I found the bug or see here for web version:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108704334308688&w=2


I'll put on a quick 2.4.26 fix that should work (can't test, since my
linux box that I have physical access to isn't wired to the Internett
currently)


Stian Skjelstad
