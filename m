Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbTFYXs7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 19:48:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbTFYXs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 19:48:59 -0400
Received: from holomorphy.com ([66.224.33.161]:25221 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265128AbTFYXs6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 19:48:58 -0400
Date: Wed, 25 Jun 2003 17:02:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Brian Jackson <brian@brianandsara.net>
Cc: Orion Poplawski <orion@cora.nwra.com>, linux-kernel@vger.kernel.org
Subject: Re: Is their an explanation of various kernel versions/brances/patches/? (-mm, -ck, ..)
Message-ID: <20030626000250.GR26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Brian Jackson <brian@brianandsara.net>,
	Orion Poplawski <orion@cora.nwra.com>, linux-kernel@vger.kernel.org
References: <bdd64m$3dr$1@main.gmane.org> <200306251857.48341.brian@brianandsara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306251857.48341.brian@brianandsara.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 06:57:48PM -0500, Brian Jackson wrote:
> pgcl - William Lee Irwin - ?

Page clustering. A vague attempt at a forward port of Hugh Dickins'
2.4.7 patch for the same purpose, WIP. I'd say it's more of one patch
than a patch set.


-- wli
