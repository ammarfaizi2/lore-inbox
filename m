Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S131499AbRC1OH6>; Wed, 28 Mar 2001 09:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S131832AbRC1OHt>; Wed, 28 Mar 2001 09:07:49 -0500
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:26129 "HELO sysadmin.sportingbet.com") by vger.kernel.org with SMTP id <S131499AbRC1OHg>; Wed, 28 Mar 2001 09:07:36 -0500
Date: Wed, 28 Mar 2001 15:10:08 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Shawn Starr <spstarr@sh0n.net>, Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
Subject: Re: Disturbing news..
Message-ID: <20010328151008.D8235@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>, Jesse Pollard <jesse@cats-chateau.net>, Shawn Starr <spstarr@sh0n.net>, Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.30.0103280225460.8046-100000@coredump.sh0n.net> <01032806093901.11349@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <01032806093901.11349@tabby>; from jesse@cats-chateau.net on Wed, Mar 28, 2001 at 06:08:15AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 06:08:15AM -0600, Jesse Pollard wrote:
> Sure - very simple. If the execute bit is set on a file, don't allow
> ANY write to the file. This does modify the permission bits slightly
> but I don't think it is an unreasonable thing to have.
> 

Are we not then in the somewhat zen-like state of having an "rm" which can't
"rm" itself without needing to be made non-executable so that it can't execute?

Sean
