Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317542AbSGJQpa>; Wed, 10 Jul 2002 12:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317543AbSGJQp3>; Wed, 10 Jul 2002 12:45:29 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:63760 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S317542AbSGJQp2>;
	Wed, 10 Jul 2002 12:45:28 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200207101648.g6AGm25389637@saturn.cs.uml.edu>
Subject: Re: bzip2 patent status query
To: jbradford@dial.pipex.com
Date: Wed, 10 Jul 2002 12:48:02 -0400 (EDT)
Cc: cl81@gmx.net (Christian Ludwig), linux-kernel@vger.kernel.org
In-Reply-To: <200207101554.QAA07949@darkstar.example.net> from "jbradford@dial.pipex.com" at Jul 10, 2002 04:54:51 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jbradford@dial.pip writes:

> Is bzip2 *definitely* patent-unencumbered?

You could ask a lawyer and hope he's right...

> It claims to be on it's home page, but I found this from the OpenBSD people:
> 
> http://www.openbsd.org/2.8_packages/m68k/bzip-0.21.tgz-long.html

...but that's not bzip2. It's the original bzip, which used
an arithmetic encoding in the final stage. The bzip2 program
won't even read files created with bzip.
