Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263350AbTDLSLy (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 14:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTDLSLy (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 14:11:54 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:7694
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S263350AbTDLSLy 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 14:11:54 -0400
Subject: Re: Processor sets (pset) for linux kernel 2.5/2.6?
From: Robert Love <rml@tech9.net>
To: Antonio Vargas <wind@cocodriloo.com>
Cc: "Shaheed R. Haque" <srhaque@iee.org>, linux-kernel@vger.kernel.org,
       thockin@isunix.it.ilstu.edu
In-Reply-To: <20030412122422.GB9125@wind.cocodriloo.com>
References: <1050146434.3e97f68300fff@netmail.pipex.net>
	 <20030412122422.GB9125@wind.cocodriloo.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050171807.2291.455.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 12 Apr 2003 14:23:27 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-04-12 at 08:24, Antonio Vargas wrote:

> I think it's carried over by fork(), but have been unable to find
> it on the sources.

Yep, its inherited over fork().

	Robert Love

