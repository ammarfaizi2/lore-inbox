Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTDDOir (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 09:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbTDDOia (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 09:38:30 -0500
Received: from s161-184-77-200.ab.hsia.telus.net ([161.184.77.200]:57758 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S263717AbTDDObO (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 09:31:14 -0500
Date: Fri, 4 Apr 2003 07:42:34 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Nicholas Henke <henken@seas.upenn.edu>
cc: jgarzik@pobox.com, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: eepro100 oops on 2.4.20
In-Reply-To: <20030403142457.14227434.henken@seas.upenn.edu>
Message-ID: <Pine.LNX.4.44.0304040739130.8912-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Apr 2003, Nicholas Henke wrote:

> Below is the patch that fixes an oops on 2.4.20 when insmod'ing eepro100.
>  Looks like a trivial 'oops forgot to replace those' case.

Hi,
FYI, your patch doesn't work against clean 2.4.20...  Did you take this
against 2.4.20 or against the bk tree?

Thanks and regards
James Bourne


-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  

