Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261688AbTD2Ubc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 16:31:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbTD2Ubc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 16:31:32 -0400
Received: from ulima.unil.ch ([130.223.144.143]:44418 "EHLO ulima.unil.ch")
	by vger.kernel.org with ESMTP id S261688AbTD2Ubb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 16:31:31 -0400
Date: Tue, 29 Apr 2003 22:43:50 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: Paul Bristow <paul@paulbristow.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: no ZIP (250) with 2.4.21-rc1-ac3...
Message-ID: <20030429204350.GA12519@ulima.unil.ch>
References: <20030429164913.GA10060@ulima.unil.ch> <3EAEC4BE.1040702@paulbristow.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EAEC4BE.1040702@paulbristow.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 29, 2003 at 08:30:22PM +0200, Paul Bristow wrote:

> You could use the ide-floppy driver instead of the ide-scsi driver.  
> This should work.

You are completely right ;-)
It works really good, thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
