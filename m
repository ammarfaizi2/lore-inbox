Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965192AbWJKIzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965192AbWJKIzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 04:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965195AbWJKIzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 04:55:13 -0400
Received: from mail.charite.de ([160.45.207.131]:8865 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S965192AbWJKIzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 04:55:11 -0400
Date: Wed, 11 Oct 2006 10:55:05 +0200
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: The Future of ReiserFS development
Message-ID: <20061011085505.GH10027@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <64b272cb0610110153t1da8475fp2586ed09292ed258@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b272cb0610110153t1da8475fp2586ed09292ed258@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What is the plan? Could i
> migrate from reiserfs to another journaling filesystem?

Of course: Simply backup, mkfs and restore!

-- 
Ralf Hildebrandt (i.A. des IT-Zentrums)         Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
