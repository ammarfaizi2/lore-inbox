Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbTJANXU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 09:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262015AbTJANXU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 09:23:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64907 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261872AbTJANXU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 09:23:20 -0400
Date: Wed, 1 Oct 2003 14:23:18 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: "Lisa R. Nelson" <lisanels@cableone.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: File Permissions are incorrect. Security flaw in Linux
Message-ID: <20031001132318.GS7665@parcelfarce.linux.theplanet.co.uk>
References: <1065012013.4078.2.camel@lisaserver>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065012013.4078.2.camel@lisaserver>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 06:40:13AM -0600, Lisa R. Nelson wrote:
> [1.] One line summary of the problem:    
> A low level user can delete a file owned by root and belonging to group
> root even if the files permissions are 744.  This is not in agreement
> with Unix, and is a major security issue.

No, it's your well-earned F for Unix 101.  You should focus on Unix permissions
model in general and sticky bit in particular when you take the course again.
Have a nice semester.
