Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262092AbTJSJB6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 05:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbTJSJB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 05:01:58 -0400
Received: from codepoet.org ([166.70.99.138]:44986 "EHLO codepoet.org")
	by vger.kernel.org with ESMTP id S262092AbTJSJB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 05:01:56 -0400
Date: Sun, 19 Oct 2003 03:01:50 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Norman Diamond '" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>,
       "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>,
       "'nikita@namesys.com '" <nikita@namesys.com>,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
Message-ID: <20031019090149.GA20951@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Hans Reiser <reiser@namesys.com>,
	Andre Hedrick <andre@linux-ide.org>,
	"Mudama, Eric" <eric_mudama@Maxtor.com>,
	'Norman Diamond ' <ndiamond@wta.att.ne.jp>,
	'Wes Janzen ' <superchkn@sbcglobal.net>,
	'Rogier Wolff ' <R.E.Wolff@BitWizard.nl>,
	'John Bradford ' <john@grabjohn.com>,
	"'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>,
	"'nikita@namesys.com '" <nikita@namesys.com>,
	'Pavel Machek ' <pavel@ucw.cz>,
	'Justin Cormack ' <justin@street-vision.com>,
	'Russell King ' <rmk+lkml@arm.linux.org.uk>,
	'Vitaly Fertman ' <vitaly@namesys.com>,
	'Krzysztof Halasa ' <khc@pm.waw.pl>
References: <Pine.LNX.4.10.10310190120330.15306-100000@master.linux-ide.org> <3F924AF2.3010104@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F924AF2.3010104@namesys.com>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Oct 19, 2003 at 12:27:30PM +0400, Hans Reiser wrote:
> What is DCO oh cryptic industry insider.;-)

See "6.21 Device Configuration Overlay feature set" in 
the ATA6 spec...

"The optional Device Configuration Overlay feature set allows a
utility program to modify some of the optional commands, modes,
and feature sets that a device reports as supported in the
IDENTIFY DEVICE or IDENTIFY PACKET DEVICE command response as
well as the capacity reported."

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
