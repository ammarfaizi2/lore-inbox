Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266497AbTABUbW>; Thu, 2 Jan 2003 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266489AbTABUbW>; Thu, 2 Jan 2003 15:31:22 -0500
Received: from mail.webmaster.com ([216.152.64.131]:53406 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S266491AbTABUbV> convert rfc822-to-8bit; Thu, 2 Jan 2003 15:31:21 -0500
From: David Schwartz <davids@webmaster.com>
To: <paul@clubi.ie>
CC: <Hell.Surfers@cwctv.net>, <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Thu, 2 Jan 2003 12:39:47 -0800
In-Reply-To: <Pine.LNX.4.44.0301012356270.8691-100000@fogarty.jakma.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030102203949.AAA9589@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>How are the standard interfaces not covered by the GPL?

	Surely you aren't arguing that someone can copyright

int open(const char *, int);

	Are you?

	There's the battle and there's the war. The GPL is the battle. If you argue 
that any code that goes anywhere near anyone else's code is a derived work, 
you may win the battle by buttressing the GPL, but you will lose the war.

	The open source community wasn't the first to use  'int open(const char *, 
int)'. If you want to argue that this is an interface that can be 
copyrighted, then we're all screwed.

	Defending fair use and first sale type doctrines and rejecting shrink wrap 
agreements is far more important than defending the GPL.

	Using someone else's header file to develop code is *use*, not distribution. 
That's what header files are for -- that's how you *use* them, by including 
them. If someone wants to substitute more stringent restrictions, then they 
can do that by contract.

	DS


