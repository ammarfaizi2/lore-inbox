Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262110AbTJANxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTJANxY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:53:24 -0400
Received: from calvin.stupendous.org ([213.84.70.4]:27405 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S262110AbTJANxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:53:23 -0400
Date: Wed, 1 Oct 2003 15:53:22 +0200
From: Jurjen Oskam <jurjen@stupendous.org>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: File Permissions are incorrect. Security flaw in Linux
Message-ID: <20031001135322.GA16692@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <1065012013.4078.2.camel@lisaserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065012013.4078.2.camel@lisaserver>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 06:40:13AM -0600, Lisa R. Nelson wrote:

> [1.] One line summary of the problem:    
> A low level user can delete a file owned by root and belonging to group
> root even if the files permissions are 744.  This is not in agreement
> with Unix, and is a major security issue.

This *is* in agreement with Unix. It works exactly the same on AIX, for
example.

-- 
Jurjen Oskam

PGP Key available at http://www.stupendous.org/
