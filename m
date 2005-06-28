Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVF1Ceg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVF1Ceg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 22:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVF1Ceg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 22:34:36 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:38580 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262387AbVF1Ceb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 22:34:31 -0400
Subject: Re: reiser4 plugins
From: Lee Revell <rlrevell@joe-job.com>
To: David Masover <ninja@slaphack.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Hans Reiser <reiser@namesys.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <42C08B5E.2080000@slaphack.com>
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	 <42BCD93B.7030608@slaphack.com>
	 <200506251420.j5PEKce4006891@turing-police.cc.vt.edu>
	 <42BDA377.6070303@slaphack.com>
	 <200506252031.j5PKVb4Y004482@turing-police.cc.vt.edu>
	 <42BDC422.6020401@namesys.com> <42BE3645.4070806@cisco.com>
	 <e692861c05062522071fe380a5@mail.gmail.com> <42BE563D.4000402@cisco.com>
	 <42BE5DB6.8040103@slaphack.com>
	 <200506261816.j5QIGMdI010142@turing-police.cc.vt.edu>
	 <42BF08CF.2020703@slaphack.com>
	 <200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
	 <42BF2DC4.8030901@slaphack.com>
	 <200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
	 <42BF667C.50606@slaphack.com>
	 <5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>
	 <42BF7167.80201@slaphack.com>
	 <EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>
	 <42C06D59.2090200@slaphack.com>
	 <CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>
	 <42C08B5E.2080000@slaphack.com>
Content-Type: text/plain
Date: Mon, 27 Jun 2005 22:34:26 -0400
Message-Id: <1119926066.13519.6.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-27 at 18:27 -0500, David Masover wrote:
> Right on all points.  Just remember that some change is good.  Why do
> we
> have ALSA now?  Everything a user can do with ALSA, they can do with
> OSS, AFAIK.
> 

Wrong, you have it backwards.  The ALSA API is a superset of the OSS
API.  Otherwise, what would the point have been?

Lee

