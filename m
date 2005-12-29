Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbVL2LKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVL2LKy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVL2LKy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:10:54 -0500
Received: from fiberbit.xs4all.nl ([213.84.224.214]:50069 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S932591AbVL2LKx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:10:53 -0500
Date: Thu, 29 Dec 2005 12:10:50 +0100
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Luke Yang <luke.adi@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel development process questions (updating git tags)
Message-ID: <20051229111049.GA21090@fiberbit.xs4all.nl>
References: <489ecd0c0512202117q303ef7f1qae6bc08c9637be39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <489ecd0c0512202117q303ef7f1qae6bc08c9637be39@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday December 21st 2005 Luke Yang wrote:

> BTW:  git question, Is there any way to get my .git/refs/ folder
> updated through http? I mean not through rsync?

$ git fetch --tags

or even shorter:

$ git fetch -t
-- 
Marco Roeland
