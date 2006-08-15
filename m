Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965112AbWHOFm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965112AbWHOFm0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 01:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965113AbWHOFm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 01:42:26 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:3983 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S965112AbWHOFmZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 01:42:25 -0400
Subject: Re: scripts/export_report.pl doesn't support O= builds
From: Ram Pai <linuxram@us.ibm.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Sam Ravnborg <sam@mars.ravnborg.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060815021100.GI3543@stusta.de>
References: <20060815021100.GI3543@stusta.de>
Content-Type: text/plain
Organization: IBM 
Date: Mon, 14 Aug 2006 22:42:20 -0700
Message-Id: <1155620540.5724.362.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-15 at 04:11 +0200, Adrian Bunk wrote:
> scripts/export_report.pl doesn't support O= builds.
> 
> Could this be fixed?

Adrian,
	I am assuming you are expecting the functionality integrated in
	the kbuild?  

	If yes, I had the patch submitted long back. I
	can resubmit the patch. However Sam felt that having it
        integrated into the kbuild added little value.

RP


