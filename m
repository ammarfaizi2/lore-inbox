Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263144AbSJGP5r>; Mon, 7 Oct 2002 11:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263151AbSJGP5r>; Mon, 7 Oct 2002 11:57:47 -0400
Received: from ned.select-tech.si ([193.77.122.2]:11239 "EHLO
	mail-gw.select-tech.si") by vger.kernel.org with ESMTP
	id <S263144AbSJGP5r>; Mon, 7 Oct 2002 11:57:47 -0400
Message-Id: <200210071603.g97G3c226136@stsrv.select-tech.si>
Date: Mon, 7 Oct 2002 18:03:18 +0200
From: Jure Pecar <Jure.Pecar@select-tech.si>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: more fun with intel se7500wv2
Organization: Select Technology
X-Mailer: Sylpheed version 0.8.3 (GTK+ 1.2.9; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002 17:40:49 +0200
Jure Pecar <jure.pecar@select-tech.si> wrote:

> All dmesgs stop at scsi, which is already
> being looked at. 

Ok, Justin Gibbs just told me that this is an interrupt routing problem
and not a driver problem. Who can i ask more about that?
I'm really eager to have this box running properly with 2.5 kernel.

--

Jure Pecar
