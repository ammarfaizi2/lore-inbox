Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262197AbTE2Mi4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 08:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbTE2Mi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 08:38:56 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:29962 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262197AbTE2Miz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 08:38:55 -0400
Date: Thu, 29 May 2003 14:55:59 +0200
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.70-mm2 still dies with RAID-1
Message-ID: <20030529125559.GA2210@hh.idb.hist.no>
References: <20030529012914.2c315dad.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030529012914.2c315dad.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.5.70-mm2 still crash during boot in
exactly the same way as 2.5.70-mm1.
The final oops is the same.

Helge Hafting
