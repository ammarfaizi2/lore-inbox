Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264054AbTDWOjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264056AbTDWOjA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:39:00 -0400
Received: from franka.aracnet.com ([216.99.193.44]:42458 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264054AbTDWOi7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:38:59 -0400
Date: Wed, 23 Apr 2003 07:51:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-ID: <18400000.1051109459@[10.10.2.4]>
In-Reply-To: <20030423012046.0535e4fd.akpm@digeo.com>
References: <20030423012046.0535e4fd.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> . I got tired of the objrmap code going BUG under stress, so it is now in
>   disgrace in the experimental/ directory.

Any chance of some more info on that? BUG at what point in the code,
and with what test to reproduce?

M.

