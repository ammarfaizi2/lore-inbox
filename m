Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVFWW4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVFWW4f (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:56:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262881AbVFWWy0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:54:26 -0400
Received: from sinclair.provo.novell.com ([137.65.81.169]:62507 "EHLO
	sinclair.provo.novell.com") by vger.kernel.org with ESMTP
	id S262854AbVFWWyS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:54:18 -0400
Message-Id: <s2bae938.075@sinclair.provo.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.4 
Date: Thu, 23 Jun 2005 16:54:09 -0600
From: "Clyde Griffin" <CGRIFFIN@novell.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Clyde Griffin" <CGRIFFIN@novell.com>, "Jan Beulich" <JBeulich@novell.com>
Subject: Novell Linux Kernel Debugger (NLKD)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Novell engineering is introducing the Novell Linux Kernel Debugger (NLKD) as an open source project intended to provide an enhanced and robust debugging experience for Linux kernel developers. 

The project (nlkd) at http://forge.novell.com/modules/xfmod/project/?nlkd currently has code patches to SUSE Linux Enterprise Server v9 SP1 and SP2, which when applied allow kernel developers to recompile the Linux kernel exposing the functionality provided by NLKD.  

Patches against the mainline will be forthcoming after community feedback.

At this point the intent of this project is to gather comments and suggestions on how to improve NLKD and make it possible for NLKD to be included as a native (mainline) kernel debugger for Linux.  Novell engineering will be actively involved in reviewing comments regarding NLKD and submitting and receiving patches for the support of NLKD.
 
NLKD provides an architecture for supporting a stable debugging experience as well as debug agents supporting local and remote debugging.  NLKD's Console Debug Agent (CDA) supports on-box kernel debugging and is extremely rich in functionality and easy to use.  The Remote Debug Agent (RDA) supports remote source level debugging via gdbtransport to your favorite gdb based client.  Both agents benefit from the Core Debug Engine (CDE), which provides the state machine logic supporting the debug agents.

A detailed description of the architecture will be presented in a paper titled "The Novell Linux Kernel Debugger, NLKD" at the Ottawa Linux Symposium July 20-23, 2005.

NLKD provides debugging capabilities that will be a benefit to the whole development community and we invite developers interested in using NLKD to download the patches, provide feedback, and benefit from the use of this great tool.

Developers interested in commenting on, contributing to, testing, documenting, and improving NLKD should subscribe to the nlkd-dev mailing list at http://forge.novell.com/modules/xfmod/project/?nlkd and post to nlkd-dev@forge.novell.com.



