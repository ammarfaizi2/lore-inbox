Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263273AbSJHTTr>; Tue, 8 Oct 2002 15:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263275AbSJHTSd>; Tue, 8 Oct 2002 15:18:33 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:1028 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S263273AbSJHTSP>;
	Tue, 8 Oct 2002 15:18:15 -0400
Date: Tue, 8 Oct 2002 21:23:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: JBD Documentation added in BK-current
Message-ID: <20021008212310.A13265@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The JBD documentation have been added in BK-current.
But 'compiling' the documentation result in a lot of SGML related
errors.

Someone knowing SGML that care to take a look?

[I'm cleaning up the mess in the Makefile after JBD was added right now].

	Sam

  DB2PS   Documentation/DocBook/journal-api.ps
Using catalogs: /etc/sgml/sgml-docbook-3.1.cat
Using stylesheet: /usr/share/sgml/docbook/utils-0.6.9/docbook-utils.dsl#print
Working on: /home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/journal-api.sgml
jade:/home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/journal-api.sgml:211:5:E: document type does not allow element "PARA" here; missing one of "FOOTNOTE", "MSGTEXT", "CAUTION", "IMPORTANT", "NOTE", "TIP", "WARNING", "BLOCKQUOTE", "INFORMALEXAMPLE" start-tag
jade:/home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/journal-api.sgml:212:7:E: end tag for "PARA" omitted, but OMITTAG NO was specified
jade:/home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/journal-api.sgml:211:0: start tag was here
jade:/home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/journal-api.sgml:212:7:E: end tag for "PARA" omitted, but OMITTAG NO was specified
jade:/home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/journal-api.sgml:195:0: start tag was here
jade:/home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/journal-api.sgml:248:9:E: end tag for "PARA" omitted, but OMITTAG NO was specified
jade:/home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/journal-api.sgml:215:0: start tag was here
jade:/home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/journal-api.sgml:248:9:E: end tag for "SECT1" omitted, but OMITTAG NO was specified
jade:/home/sam/src/linux/kernel/bk/clean3/Documentation/DocBook/journal-api.sgml:213:0: start tag was here


