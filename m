Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbULWUeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbULWUeF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 15:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbULWUeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 15:34:05 -0500
Received: from mx1.mail.ru ([194.67.23.121]:1036 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S261228AbULWUeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 15:34:03 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Something wrong when transform Documentation/DocBook/*.tmpl into pdf
Date: Thu, 23 Dec 2004 23:33:01 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412232333.01349.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2004-12-23 19:39:25, Park Lee wrote:

> cd /usr/src/linux-2.6.5-1.358/Documentation/DocBook 
> <ENTER>
> make pdfdocs  <ENTER>

Correct sequence is:

$ cd /usr/src/linux-whatever/
$ make pdfdocs

pdfs will be at Documentation/DocBook/

	Alexey
