Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965158AbWJJM0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158AbWJJM0L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 08:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965160AbWJJM0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 08:26:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:10157 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965158AbWJJM0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 08:26:09 -0400
Subject: Re: 2.6.19-rc1-mm1
From: Arjan van de Ven <arjan@infradead.org>
To: Theodore Tso <tytso@mit.edu>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061010121950.GA25809@thunk.org>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <20061010121950.GA25809@thunk.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 10 Oct 2006 14:26:03 +0200
Message-Id: <1160483163.3000.296.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Mount -o nobh is a different story, since that's just a implementation
> detail --- although for ext4, maybe we should just make nobh a
> default, since that way more people will test it and hopefully,
> eventually nobh will be the only way of doing things, right?

imo it should be that even for ext3!


