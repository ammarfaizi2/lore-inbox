Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267032AbTAUPz0>; Tue, 21 Jan 2003 10:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267050AbTAUPz0>; Tue, 21 Jan 2003 10:55:26 -0500
Received: from sprocket.loran.com ([209.167.240.9]:20212 "EHLO
	ottonexc1.peregrine.com") by vger.kernel.org with ESMTP
	id <S267032AbTAUPzZ>; Tue, 21 Jan 2003 10:55:25 -0500
Subject: Re: Is the BitKeeper network protocol documented?
From: Dana Lacoste <dana.lacoste@peregrine.com>
To: David Schwartz <davids@webmaster.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030120190037.AAA15691@shell.webmaster.com@whenever>
References: <20030120190037.AAA15691@shell.webmaster.com@whenever>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 21 Jan 2003 11:04:31 -0500
Message-Id: <1043165072.1397.61.camel@dlacoste.ottawa.loran.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-20 at 14:00, David Schwartz wrote:

> 	I think you're entirely dropping the context. If the development of 
> a project is centered around a version control system, then that 
> version control system contains metainformation that is useful when 
> you're making modifications.

No, you're missing something very very very important here
(that someone else followed up with but you missed their point too)

The GPL was fundamentally designed to allow for the freedom to
modify the products that you have under the GPL.

This means that the source code to the product you have must be
in a form that is modifiable, and it must be in the 'preferred'
form for YOU to modify that code.

This has NOTHING to do with patches and tracking changes and
communicating with Linus.  This has to do with the code to the
software you use and YOUR ability to change it.

Thus you can take any release of Linux's source and add it into
BK or p4 or CVS or rcs/sccs and you can make your own changes to
that source code.  The binary you have was created from that
source code and the GPL protects your right to modify that source
code.

BK is merely a way that the product authors can manage their changelists
over time.  The BK information is not used in the build of the binary,
therefore it is not part of the binary and not having it is not
preventing you from modifying the source code to the binary you do have.
Even if you got it from Red Hat.

Dana Lacoste
Ottawa, Canada

