Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262086AbTJSINy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262092AbTJSINy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:13:54 -0400
Received: from users.linvision.com ([62.58.92.114]:54656 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262086AbTJSINw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:13:52 -0400
Date: Sun, 19 Oct 2003 10:13:49 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
Cc: "'Norman Diamond '" <ndiamond@wta.att.ne.jp>,
       "'Hans Reiser '" <reiser@namesys.com>,
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
Message-ID: <20031019081349.GA21346@bitwizard.nl>
References: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 01:37:03AM -0600, Mudama, Eric wrote:
> About 2.5 years ago, Maxtor's largest drive was 60GB... 15GB/head.  Now
> we're shipping 250GB drives with 6 heads also... ~42GB/head, almost triple

Know your maxtor drives: Maxtor has been shipping 4-platter, 8 head
drives for quite a long time. Only recently am I starting to see the
largest maxtor-drive from a family having the space to carry 4 
platters, but none of the expected capacity are shipping (*).... Care 
to explain?

Eric, do you know why maxtor stopped putting the number of heads 
in the model number? (It's the last number in the model number, just
after the letter. Currently all drives set this to "0"). It was quite 
convenient for us to know what to expect from a 92720U8, 98196H8, 
96147H8 and 4G160J8. (Hmmm apparently, we're mostly buying the 
"largest of the family" drives: they all have 8 heads! I just
looked at the models in some of our computers.)

			Roger. 

(e.g. the 250G model seems to be a 6-head disk, and not 8-head). 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
