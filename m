Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265151AbTFRLYS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 07:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265153AbTFRLYR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 07:24:17 -0400
Received: from mail.skjellin.no ([80.239.42.67]:31962 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S265151AbTFRLYR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 07:24:17 -0400
Subject: Re: ptrace/kmod exploit still works in 2.4.21?
From: Andre Tomt <andre@tomt.net>
To: Pete Taphouse <pete@bytemark.co.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200306181222.11691.pete@bytemark.co.uk>
References: <200306181222.11691.pete@bytemark.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1055936287.7480.136.camel@slurv.ws.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 18 Jun 2003 13:38:07 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ons, 2003-06-18 at 13:22, Pete Taphouse wrote:
<snip FAQ>

Check your exploit binary for the suid flag. If run successfully once on
a older kernel, it cheats by setting suid root.

-- 
Mvh,
André Tomt

