Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261477AbVF0FJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261477AbVF0FJJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 01:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVF0FJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 01:09:09 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:12442 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S261477AbVF0FJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 01:09:06 -0400
Message-ID: <42BF89F6.3020200@namesys.com>
Date: Sun, 26 Jun 2005 22:09:10 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: David Masover <ninja@slaphack.com>, Lincoln Dale <ltd@cisco.com>,
       Gregory Maxwell <gmaxwell@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl> <42BCD93B.7030608@slaphack.com> <200506251420.j5PEKce4006891@turing-police.cc.vt.edu> <42BDA377.6070303@slaphack.com> <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu> <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com> <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com> <42BE5DB6.8040103@slaphack.com> <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu> <42BF08CF.2020703@slaphack.com> <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu> <42BF2DC4.8030901@slaphack.com> <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>            <42BF667C.50606@slaphack.com> <200506270427.j5R4RYiO004629@turing-police.cc.vt.edu>
In-Reply-To: <200506270427.j5R4RYiO004629@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>>tarball/zipfile.  Nobody ever suggested that you would actually want to.
>>    
>>
> Besides, your point was that you could not run make inside of a kernel
>
Umm, try it when we have it working, on a 1-4GB RAM machine it might not
be so bad.....  We have the compression (albeit still with bugs) but not
the tar plugin.
