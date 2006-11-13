Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754501AbWKMLaX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754501AbWKMLaX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 06:30:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754499AbWKMLaX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 06:30:23 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:23707 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1754498AbWKMLaW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 06:30:22 -0500
Message-ID: <45585749.5030200@op5.se>
Date: Mon, 13 Nov 2006 12:30:17 +0100
From: Andreas Ericsson <ae@op5.se>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Marco Costalba <mcostalba@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] qgit-1.5.3
References: <e5bfff550611110006p44494ed4h2979232bfc8e957c@mail.gmail.com>
In-Reply-To: <e5bfff550611110006p44494ed4h2979232bfc8e957c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marco Costalba wrote:
> 
> Download tarball from http://www.sourceforge.net/projects/qgit
> or directly from git public repository
> git://git.kernel.org/pub/scm/qgit/qgit.git
> 

Love the tool, but can't fetch the tag. Did you forget to

	$ git push origin 1.5.3

?

git describe tells me that I have qgit-1.5.2-gb764f9b

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
