Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422932AbWJYEOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422932AbWJYEOb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 00:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422933AbWJYEOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 00:14:31 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:57753 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1422932AbWJYEOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 00:14:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hJeuGm1I2bl1DUp3MKYHCj4GjxOazAEq6F449u+9bOYlDST990n85S2HLktRUZo4PK5J7GrtjORxh8fnQzLJm2/nL10OEOPrG9fsJP7qqHHkN3DFJm6Gh5en98GnV4t3uFXuXYZZmMj9vhvmDDm+x15UjkeORo0JOHzFJetxvTA=
Message-ID: <2c0942db0610242112r738fe4ccg8702ef5175a7927c@mail.gmail.com>
Date: Tue, 24 Oct 2006 21:12:43 -0700
From: "Ray Lee" <madrabbit@gmail.com>
Reply-To: ray-gmail@madrabbit.org
To: Michael <michael.sallaway@gmail.com>
Subject: Re: PROBLEM: Oops when doing disk heavy disk I/O
Cc: sergio@sergiomb.no-ip.org, linux-kernel@vger.kernel.org
In-Reply-To: <453ebcfd.615c691e.52ef.2927@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161736906.2922.14.camel@localhost.portugal>
	 <453ebcfd.615c691e.52ef.2927@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It seems to be related to interrupts, somehow... since I'm not too familiar
> with what's happening, would anyone have any suggestions about what I could
> do next to troubleshoot?

Try swapping out the RAM (or getting it down to 1Gig). Try a really
old kernel, such as debian's 2.6.8 package.

Ray
