Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261471AbRE2JOI>; Tue, 29 May 2001 05:14:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261473AbRE2JNs>; Tue, 29 May 2001 05:13:48 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34824 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261471AbRE2JNk>; Tue, 29 May 2001 05:13:40 -0400
Subject: Re: Plain 2.4.5 VM...
To: jakob@unthought.net (=?iso-8859-1?Q?Jakob_=D8stergaard?=)
Date: Tue, 29 May 2001 10:10:41 +0100 (BST)
Cc: ghsong@kjist.ac.kr (G. Hugh Song), linux-kernel@vger.kernel.org
In-Reply-To: <20010529061039.D29962@unthought.net> from "=?iso-8859-1?Q?Jakob_=D8stergaard?=" at May 29, 2001 06:10:39 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E154fWT-0004BO-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not a bug.  It's a feature.  It only breaks systems that are run w=
> ith "too
> little" swap, and the only difference from 2.2 till now is, that the de=
> finition
> of "too little" changed.

its a giant bug. Or do you want to add 128Gb of unused swap to a full kitted
out Xeon box - or 512Gb to a big athlon ???
