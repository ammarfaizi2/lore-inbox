Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267426AbTBLSfX>; Wed, 12 Feb 2003 13:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbTBLSfX>; Wed, 12 Feb 2003 13:35:23 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:42257 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267426AbTBLSfX>; Wed, 12 Feb 2003 13:35:23 -0500
Date: Wed, 12 Feb 2003 18:45:08 +0000
From: "'Christoph Hellwig'" <hch@infradead.org>
To: "Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>
Cc: "'Christoph Hellwig'" <hch@infradead.org>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030212184507.A15023@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	"Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
	linux-security-module@wirex.com, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <7B2A7784F4B7F0409947481F3F3FEF8305CC954F@eammlex037.lmc.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <7B2A7784F4B7F0409947481F3F3FEF8305CC954F@eammlex037.lmc.ericsson.se>; from Makan.Pourzandi@ericsson.ca on Wed, Feb 12, 2003 at 11:58:52AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

do you have any technical argument on the current implementation of
security hooks?  the whole discussion is on removing the current mess
until a proper design can be implemented.
