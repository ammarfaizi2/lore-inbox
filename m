Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbVJCFbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbVJCFbA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 01:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbVJCFbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 01:31:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4777 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932087AbVJCFa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 01:30:59 -0400
Date: Sun, 2 Oct 2005 22:30:50 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Paul Jackson <pj@sgi.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] Document from line in patch format
Message-Id: <20051002223050.11a287eb.zaitcev@redhat.com>
In-Reply-To: <mailman.1128301576.22577.linux-kernel2news@redhat.com>
References: <mailman.1128301576.22577.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2 Oct 2005 18:01:42 -0700 (PDT), Paul Jackson <pj@sgi.com> wrote:

> +    Subject: [PATCH 001/123] [<area>:] <explanation>

An attack of rabid square brackets! :-)

Linus' original e-mail made it quite clear that the area does not
need its own brackets, but this detail seems to have been lost.

-- Pete
