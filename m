Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263017AbTDIMAo (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 08:00:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbTDIMAo (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 08:00:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:28571
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263017AbTDIMAn (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 9 Apr 2003 08:00:43 -0400
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges (was:
	[MAILER-DAEMON@rumms.u
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304082124_MC3-1-3399-FBD0@compuserve.com>
References: <200304082124_MC3-1-3399-FBD0@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049886804.9901.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Apr 2003 12:13:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-04-09 at 02:21, Chuck Ebbert wrote:
> And your code goes for long periods of time without merging good fixes,
> like this one (from 2.4.20):

Which is one reason Justin's patches don't get merged. They are giant
changes which back out other clear corrections.

