Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751199AbWDXT6I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbWDXT6I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:58:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbWDXT6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:58:08 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:1768 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751199AbWDXT6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:58:07 -0400
Subject: Re: Removing .tmp_versions considered harmful
From: Arjan van de Ven <arjan@infradead.org>
To: Pavel Roskin <proski@gnu.org>
Cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1145908527.2292.39.camel@dv>
References: <1145593342.2904.30.camel@dv>
	 <20060421073216.GA17492@mars.ravnborg.org>  <1145908527.2292.39.camel@dv>
Content-Type: text/plain
Date: Mon, 24 Apr 2006 21:58:03 +0200
Message-Id: <1145908684.3116.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-24 at 15:55 -0400, Pavel Roskin wrote:
> Hello, Sam!
> 
> How about following patch?  Something needs to be done before 2.6.17.
> Complaints about .tmp_versions are almost in every list about wireless
> drivers I'm subscribed to.

seems all wireless drivers stole eachothers broken makefiles then ;)
Makes it also easy to fix I suppose


