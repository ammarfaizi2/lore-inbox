Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266596AbUFWRxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266596AbUFWRxi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 13:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265127AbUFWRxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 13:53:38 -0400
Received: from 82-147-17-1.dsl.uk.rapidplay.com ([82.147.17.1]:40017 "HELO
	82-147-17-1.dsl.uk.rapidplay.com") by vger.kernel.org with SMTP
	id S266596AbUFWRxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 13:53:37 -0400
From: Mark Watts <mrwatts@fast24.co.uk>
To: linux-kernel@vger.kernel.org, gud@eth.net
Subject: Re: Elastic Quota File System (EQFS)
Date: Wed, 23 Jun 2004 18:53:34 +0100
User-Agent: KMail/1.6.1
References: <40d9ac40.674.0@eth.net>
In-Reply-To: <40d9ac40.674.0@eth.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406231853.35201.mrwatts@fast24.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Greetings,
>
> 	I think I should discuss this in the list...
>
> 	Recently I'm into developing an Elastic Quota File System (EQFS). This
> file system works on a simple concept ... give it to others if you're not
> using it, let others use it, but on the guarantee that you get it back when
> you need it!!

How do you intend to guarantee this?
Randomly deleting a users files to free up disk space is a Bad (tm) idea, so 
what other mechanism are you going to employ?
