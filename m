Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbTJSIRT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTJSIRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:17:19 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:57766 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262078AbTJSIRS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:17:18 -0400
Message-ID: <3F92488C.6030808@namesys.com>
Date: Sun, 19 Oct 2003 12:17:16 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Mudama, Eric" <eric_mudama@Maxtor.com>
CC: "'Norman Diamond '" <ndiamond@wta.att.ne.jp>,
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
References: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com>
In-Reply-To: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric, is it true what we tell users, that if a drive can't remap a bad 
block it has probably used up all its spares, and that in turn means 
that it is wise to buy a new one because the chance of experiencing 
additional data corruption on a drive that has used up all its spares is 
much higher than the average drive?

What are the common sources of data corruption, is one of them that the 
drive head starts bumping the media more and more often because a 
bearing (or something) has started to show signs of wear?

-- 
Hans


